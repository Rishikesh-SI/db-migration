-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: ix_tcs_rating_week_ry
-- Type: INDEX

-- Name: ix_tcs_rating_week_ry; Type: INDEX; Schema: tcs; Owner: -
--

CREATE INDEX ix_tcs_rating_week_ry ON tcs.tcs_rating_week USING btree (rating_year);


--
