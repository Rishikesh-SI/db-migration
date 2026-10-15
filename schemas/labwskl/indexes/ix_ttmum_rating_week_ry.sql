-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwskl
-- Object: ix_ttmum_rating_week_ry
-- Type: INDEX

-- Name: ix_ttmum_rating_week_ry; Type: INDEX; Schema: labwskl; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_ry ON labwskl.labwskl_rating_week USING btree (rating_year);


--
