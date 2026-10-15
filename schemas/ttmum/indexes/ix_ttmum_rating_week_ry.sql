-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttmum
-- Object: ix_ttmum_rating_week_ry
-- Type: INDEX

-- Name: ix_ttmum_rating_week_ry; Type: INDEX; Schema: ttmum; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_ry ON ttmum.ttmum_rating_week USING btree (rating_year);


--
