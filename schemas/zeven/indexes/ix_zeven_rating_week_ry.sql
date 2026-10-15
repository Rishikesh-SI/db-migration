-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: ix_zeven_rating_week_ry
-- Type: INDEX

-- Name: ix_zeven_rating_week_ry; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX ix_zeven_rating_week_ry ON zeven.zeven_rating_week USING btree (rating_year);


--
