-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: ix_hsl_rating_week_woty
-- Type: INDEX

-- Name: ix_hsl_rating_week_woty; Type: INDEX; Schema: hsl; Owner: -
--

CREATE INDEX ix_hsl_rating_week_woty ON hsl.hsl_rating_week USING btree (week_of_year);


--
