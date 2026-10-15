-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cfc
-- Object: ix_cfc_rating_week_ry
-- Type: INDEX

-- Name: ix_cfc_rating_week_ry; Type: INDEX; Schema: cfc; Owner: -
--

CREATE INDEX ix_cfc_rating_week_ry ON cfc.cfc_rating_week USING btree (rating_year);


--
