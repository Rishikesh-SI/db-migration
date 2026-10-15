-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labets
-- Object: ix_ttmum_rating_week_ry
-- Type: INDEX

-- Name: ix_ttmum_rating_week_ry; Type: INDEX; Schema: labets; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_ry ON labets.labets_rating_week USING btree (rating_year);


--
