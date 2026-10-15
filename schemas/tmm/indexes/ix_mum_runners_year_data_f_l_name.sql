-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: ix_mum_runners_year_data_f_l_name
-- Type: INDEX

-- Name: ix_mum_runners_year_data_f_l_name; Type: INDEX; Schema: tmm; Owner: -
--

CREATE INDEX ix_mum_runners_year_data_f_l_name ON tmm.tmm_runners_year_data USING btree (date_of_birth, upper((last_name)::text), upper((first_name)::text));


--
