-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: ix_dd_rating_week_wn
-- Type: INDEX

-- Name: ix_dd_rating_week_wn; Type: INDEX; Schema: dd_30_04_24; Owner: -
--

CREATE INDEX ix_dd_rating_week_wn ON dd_30_04_24.dd_rating_week USING btree (week_number);


--
