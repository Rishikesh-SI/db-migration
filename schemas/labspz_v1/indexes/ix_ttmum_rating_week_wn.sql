-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labspz_v1
-- Object: ix_ttmum_rating_week_wn
-- Type: INDEX

-- Name: ix_ttmum_rating_week_wn; Type: INDEX; Schema: labspz_v1; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_wn ON labspz_v1.labspz_v1_rating_week USING btree (week_number);


--
