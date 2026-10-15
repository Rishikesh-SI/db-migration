-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs_2602
-- Object: ix_ttmum_rating_week_ry
-- Type: INDEX

-- Name: ix_ttmum_rating_week_ry; Type: INDEX; Schema: labrs_2602; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_ry ON labrs_2602.labrs_rating_week USING btree (rating_year);


--
