-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: ix_ttmum_rating_week_ry
-- Type: INDEX

-- Name: ix_ttmum_rating_week_ry; Type: INDEX; Schema: labstmp; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_ry ON labstmp.labstmp_rating_week USING btree (rating_year);


--
