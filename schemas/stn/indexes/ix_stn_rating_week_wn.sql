-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: ix_stn_rating_week_wn
-- Type: INDEX

-- Name: ix_stn_rating_week_wn; Type: INDEX; Schema: stn; Owner: -
--

CREATE INDEX ix_stn_rating_week_wn ON stn.stn_rating_week USING btree (week_number);


--
