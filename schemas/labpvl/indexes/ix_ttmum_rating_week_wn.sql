-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpvl
-- Object: ix_ttmum_rating_week_wn
-- Type: INDEX

-- Name: ix_ttmum_rating_week_wn; Type: INDEX; Schema: labpvl; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_wn ON labpvl.labpvl_rating_week USING btree (week_number);


--
