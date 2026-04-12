use anyhow::Result;
use clap::{Parser, Subcommand};

#[derive(Parser)]
#[command(name = "{{ project_name }}", version, about = "{{ description | default(project_name) }}")]
struct Cli {
    #[command(subcommand)]
    command: Command,
}

#[derive(Subcommand)]
enum Command {
    /// Print a greeting
    Hello {
        /// Name to greet
        #[arg(default_value = "world")]
        name: String,
    },
}

fn main() -> Result<()> {
    let cli = Cli::parse();
    match cli.command {
        Command::Hello { name } => {
            println!("{}", {{ project_name }}::greet(&name));
        }
    }
    Ok(())
}
