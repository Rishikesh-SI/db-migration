-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: ix_ttmum_rating_week_woty
-- Type: INDEX

-- Name: ix_ttmum_rating_week_woty; Type: INDEX; Schema: labstmp; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_woty ON labstmp.labstmp_rating_week USING btree (week_of_year);


--
