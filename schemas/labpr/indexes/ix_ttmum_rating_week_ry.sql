-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: ix_ttmum_rating_week_ry
-- Type: INDEX

-- Name: ix_ttmum_rating_week_ry; Type: INDEX; Schema: labpr; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_ry ON labpr.labpr_rating_week USING btree (rating_year);


--
