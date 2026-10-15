-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_rating_week_woty
-- Type: INDEX

-- Name: ix_abp_rating_week_woty; Type: INDEX; Schema: abpp; Owner: -
--

CREATE INDEX ix_abp_rating_week_woty ON abpp.abp_rating_week USING btree (week_of_year);


--
