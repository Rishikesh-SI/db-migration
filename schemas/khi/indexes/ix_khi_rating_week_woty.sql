-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: ix_khi_rating_week_woty
-- Type: INDEX

-- Name: ix_khi_rating_week_woty; Type: INDEX; Schema: khi; Owner: -
--

CREATE INDEX ix_khi_rating_week_woty ON khi.khi_rating_week USING btree (week_of_year);


--
