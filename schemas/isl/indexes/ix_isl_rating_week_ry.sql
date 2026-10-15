-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_rating_week_ry
-- Type: INDEX

-- Name: ix_isl_rating_week_ry; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_rating_week_ry ON isl.isl_rating_week USING btree (rating_year);


--
