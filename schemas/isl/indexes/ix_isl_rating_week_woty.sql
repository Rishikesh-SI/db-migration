-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_rating_week_woty
-- Type: INDEX

-- Name: ix_isl_rating_week_woty; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_rating_week_woty ON isl.isl_rating_week USING btree (week_of_year);


--
