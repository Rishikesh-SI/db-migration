-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cfc
-- Object: ix_cfc_page_alias
-- Type: INDEX

-- Name: ix_cfc_page_alias; Type: INDEX; Schema: cfc; Owner: -
--

CREATE INDEX ix_cfc_page_alias ON cfc.cfc_page USING btree (alias);


--
