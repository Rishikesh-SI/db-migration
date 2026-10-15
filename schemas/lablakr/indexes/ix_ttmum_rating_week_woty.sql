-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablakr
-- Object: ix_ttmum_rating_week_woty
-- Type: INDEX

-- Name: ix_ttmum_rating_week_woty; Type: INDEX; Schema: lablakr; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_woty ON lablakr.lablakr_rating_week USING btree (week_of_year);


--
