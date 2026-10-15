-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: ix_ttmum_rating_week_woty
-- Type: INDEX

-- Name: ix_ttmum_rating_week_woty; Type: INDEX; Schema: labuww; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_woty ON labuww.labuww_rating_week USING btree (week_of_year);


--
