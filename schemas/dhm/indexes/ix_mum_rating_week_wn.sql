-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: ix_mum_rating_week_wn
-- Type: INDEX

-- Name: ix_mum_rating_week_wn; Type: INDEX; Schema: dhm; Owner: -
--

CREATE INDEX ix_mum_rating_week_wn ON dhm.dhm_rating_week USING btree (week_number);


--
