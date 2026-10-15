-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_old
-- Object: ix_ttmum_rating_week_ry
-- Type: INDEX

-- Name: ix_ttmum_rating_week_ry; Type: INDEX; Schema: labbsc_old; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_ry ON labbsc_old.labbsc_rating_week USING btree (rating_year);


--
