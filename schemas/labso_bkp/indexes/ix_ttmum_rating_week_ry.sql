-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labso_bkp
-- Object: ix_ttmum_rating_week_ry
-- Type: INDEX

-- Name: ix_ttmum_rating_week_ry; Type: INDEX; Schema: labso_bkp; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_ry ON labso_bkp.labso_rating_week USING btree (rating_year);


--
