-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: ix_mum_runners_year_data_f_l_name
-- Type: INDEX

-- Name: ix_mum_runners_year_data_f_l_name; Type: INDEX; Schema: tmmimg_upd; Owner: -
--

CREATE INDEX ix_mum_runners_year_data_f_l_name ON tmmimg_upd.tmmimg_upd_runners_year_data USING btree (date_of_birth, upper((last_name)::text), upper((first_name)::text));


--
