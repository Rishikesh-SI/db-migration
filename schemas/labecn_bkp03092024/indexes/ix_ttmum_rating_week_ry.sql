-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_bkp03092024
-- Object: ix_ttmum_rating_week_ry
-- Type: INDEX

-- Name: ix_ttmum_rating_week_ry; Type: INDEX; Schema: labecn_bkp03092024; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_ry ON labecn_bkp03092024.labecn_rating_week USING btree (rating_year);


--
