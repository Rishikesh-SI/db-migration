-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: ix_zeven_rating_week_woty
-- Type: INDEX

-- Name: ix_zeven_rating_week_woty; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX ix_zeven_rating_week_woty ON zeven.zeven_rating_week USING btree (week_of_year);


--
