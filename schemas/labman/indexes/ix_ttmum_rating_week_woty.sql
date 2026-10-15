-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labman
-- Object: ix_ttmum_rating_week_woty
-- Type: INDEX

-- Name: ix_ttmum_rating_week_woty; Type: INDEX; Schema: labman; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_woty ON labman.labman_rating_week USING btree (week_of_year);


--
