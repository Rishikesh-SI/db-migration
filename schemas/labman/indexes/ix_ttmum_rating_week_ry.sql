-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labman
-- Object: ix_ttmum_rating_week_ry
-- Type: INDEX

-- Name: ix_ttmum_rating_week_ry; Type: INDEX; Schema: labman; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_ry ON labman.labman_rating_week USING btree (rating_year);


--
