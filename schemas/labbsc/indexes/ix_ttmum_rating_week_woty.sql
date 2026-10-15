-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: ix_ttmum_rating_week_woty
-- Type: INDEX

-- Name: ix_ttmum_rating_week_woty; Type: INDEX; Schema: labbsc; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_woty ON labbsc.labbsc_rating_week USING btree (week_of_year);


--
