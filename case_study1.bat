@echo off
setlocal enabledelayedexpansion

REM Define space-separated lists
@REM set models=llama deepseek qwen mistral
set models=llama
set modes=gen sel gen_sel
set temperature=0.0 0.2 0.4 0.6 0.8 1
set contracts=Crowdsale.sol:Crowdsale HoloToken.sol:HoloToken 0x899f4ee077f83a7747e4ccec8ee7aa74831a1de3.sol:USMT
set k5="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"
set num_candi=10
set iter=3
set times=1 2 3
set percentages=0.5
echo Iterating through the list:+++++++++

for %%p in (%percentages%) do (
for %%i in (%times%) do (
for %%m in (%models%) do (
    for %%t in (%temperature%) do (
        for %%c in (%contracts%) do (
            for %%o in (%modes%) do (
                for /f "tokens=2 delims=:" %%a in ("%%c") do (
                    echo Currently working on %%c : %%m : %%t : %%o: %iter%: %num_candi%: %%p: %%i
                  python ./semyth -v3  analyze ./tests/testdata/solidity_files/%%c --llm_model %%m --llm_mode %%o --api_key %k5% --temperature %%t --max_num_candi_sequences %num_candi% --iteration %iter% --times %%i --candi_percentage %%p > C:\\25_exp\\llm-based\\case_study\\%%a_%%m_%%t_%%o_%iter%_%num_candi%_%%p_output_%%i.txt

                )


            )
        )
    )
)
)
)
echo All operations successful.
endlocal
exit /b 0 REM Exit with success code 0
