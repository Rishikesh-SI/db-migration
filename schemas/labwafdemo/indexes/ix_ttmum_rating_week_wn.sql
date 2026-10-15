-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwafdemo
-- Object: ix_ttmum_rating_week_wn
-- Type: INDEX

-- Name: ix_ttmum_rating_week_wn; Type: INDEX; Schema: labwafdemo; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_wn ON labwafdemo.labwafdemo_rating_week USING btree (week_number);


--
