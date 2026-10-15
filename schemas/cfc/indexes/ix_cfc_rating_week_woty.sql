-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cfc
-- Object: ix_cfc_rating_week_woty
-- Type: INDEX

-- Name: ix_cfc_rating_week_woty; Type: INDEX; Schema: cfc; Owner: -
--

CREATE INDEX ix_cfc_rating_week_woty ON cfc.cfc_rating_week USING btree (week_of_year);


--
