-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ix_ppb_rating_week_woty
-- Type: INDEX

-- Name: ix_ppb_rating_week_woty; Type: INDEX; Schema: ppb; Owner: -
--

CREATE INDEX ix_ppb_rating_week_woty ON ppb.ppb_rating_week USING btree (week_of_year);


--
