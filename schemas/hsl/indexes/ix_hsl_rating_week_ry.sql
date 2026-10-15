-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: ix_hsl_rating_week_ry
-- Type: INDEX

-- Name: ix_hsl_rating_week_ry; Type: INDEX; Schema: hsl; Owner: -
--

CREATE INDEX ix_hsl_rating_week_ry ON hsl.hsl_rating_week USING btree (rating_year);


--
