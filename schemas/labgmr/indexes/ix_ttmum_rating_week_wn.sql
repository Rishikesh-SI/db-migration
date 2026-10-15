-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr
-- Object: ix_ttmum_rating_week_wn
-- Type: INDEX

-- Name: ix_ttmum_rating_week_wn; Type: INDEX; Schema: labgmr; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_wn ON labgmr.labgmr_rating_week USING btree (week_number);


--
