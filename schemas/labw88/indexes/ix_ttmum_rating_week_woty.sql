-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: ix_ttmum_rating_week_woty
-- Type: INDEX

-- Name: ix_ttmum_rating_week_woty; Type: INDEX; Schema: labw88; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_woty ON labw88.labw88_rating_week USING btree (week_of_year);


--
