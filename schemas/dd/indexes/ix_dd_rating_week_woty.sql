-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: ix_dd_rating_week_woty
-- Type: INDEX

-- Name: ix_dd_rating_week_woty; Type: INDEX; Schema: dd; Owner: -
--

CREATE INDEX ix_dd_rating_week_woty ON dd.dd_rating_week USING btree (week_of_year);


--
