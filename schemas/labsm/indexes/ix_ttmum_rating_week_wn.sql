-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsm
-- Object: ix_ttmum_rating_week_wn
-- Type: INDEX

-- Name: ix_ttmum_rating_week_wn; Type: INDEX; Schema: labsm; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_wn ON labsm.labsm_rating_week USING btree (week_number);


--
