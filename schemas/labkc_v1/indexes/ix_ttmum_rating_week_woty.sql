-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: ix_ttmum_rating_week_woty
-- Type: INDEX

-- Name: ix_ttmum_rating_week_woty; Type: INDEX; Schema: labkc_v1; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_woty ON labkc_v1.labkc_v1_rating_week USING btree (week_of_year);


--
