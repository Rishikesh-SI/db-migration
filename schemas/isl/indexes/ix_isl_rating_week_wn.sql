-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_rating_week_wn
-- Type: INDEX

-- Name: ix_isl_rating_week_wn; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_rating_week_wn ON isl.isl_rating_week USING btree (week_number);


--
