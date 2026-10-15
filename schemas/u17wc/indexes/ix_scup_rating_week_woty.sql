-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: ix_scup_rating_week_woty
-- Type: INDEX

-- Name: ix_scup_rating_week_woty; Type: INDEX; Schema: u17wc; Owner: -
--

CREATE INDEX ix_scup_rating_week_woty ON u17wc.u17wc_rating_week USING btree (week_of_year);


--
