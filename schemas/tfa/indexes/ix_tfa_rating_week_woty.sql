-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: ix_tfa_rating_week_woty
-- Type: INDEX

-- Name: ix_tfa_rating_week_woty; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX ix_tfa_rating_week_woty ON tfa.tfa_rating_week USING btree (week_of_year);


--
