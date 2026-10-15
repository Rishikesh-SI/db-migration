-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: ix_tcs_rating_week_wn
-- Type: INDEX

-- Name: ix_tcs_rating_week_wn; Type: INDEX; Schema: tcs; Owner: -
--

CREATE INDEX ix_tcs_rating_week_wn ON tcs.tcs_rating_week USING btree (week_number);


--
