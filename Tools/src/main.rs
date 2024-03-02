use std::path::Path;
use rodio::{Decoder};
use rodio::Source;

fn analyze_volume(path: &str) -> Option<Vec<(f64, f32)>> {
    // Load the MP3 file
    let file = std::fs::File::open(Path::new(path)).ok().unwrap();
    let mut decoder = Decoder::new(std::io::BufReader::new(file)).ok().unwrap();
    
    let mut volume_data = Vec::new();

    let duration = decoder.total_duration().unwrap().as_secs_f64();

    let samples_per_second = (decoder.channels() as u64 * decoder.sample_rate() as u64) as f64;

    let samples_per_interval = samples_per_second as f64 * 0.5; // iterate over 0.5 second intervals

    let samples = (duration * 2.0).ceil() as i64; // count in 0.5 second intervals

    for i in 0..samples {
        let mut sum = 0.0;
        let mut count = 0;

        for _ in 0..(samples_per_interval as i64) {
            if let Some(sample) = decoder.next() {
                let value = sample as i64;
                sum += value.abs() as f64;
                count += 1;
            } else {
                break;
            }
        }

        if count > 0 {
            let volume = sum / count as f64;

            volume_data.push((
                (i as f64) / 2.0, // convert back to seconds
                volume as f32,
            ));
        } else {
            break;
        }
    }
    
    // normalize to 0-1
    let mut max = 0.0;
    for (_, vol) in volume_data.iter() {
        if max == 0.0 { max = *vol };

        if vol > &max { max = *vol };
    }

    for (_, vol) in volume_data.iter_mut() {
        *vol /= max
    }

    Some(volume_data)
}

fn main() {
    let args: Vec<String> = std::env::args().collect();
    if args.len() > 1 {
        let path = &args[1];
        println!("[");
        for item in analyze_volume(path).unwrap().iter() {
            print!("{{ \"timestamp\": {:?}, \"volume\": {:?} }},", item.0, item.1)
        }
        println!("]");
    } else {
        println!("Please provide a path as an argument.");
    }
}

// WARNING: This only supports "wav" files. MP3s will panic on unwrap.