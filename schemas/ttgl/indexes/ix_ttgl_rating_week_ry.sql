-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: ix_ttgl_rating_week_ry
-- Type: INDEX

-- Name: ix_ttgl_rating_week_ry; Type: INDEX; Schema: ttgl; Owner: -
--

CREATE INDEX ix_ttgl_rating_week_ry ON ttgl.ttgl_rating_week USING btree (rating_year);


--
