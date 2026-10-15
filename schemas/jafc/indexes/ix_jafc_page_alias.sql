-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: ix_jafc_page_alias
-- Type: INDEX

-- Name: ix_jafc_page_alias; Type: INDEX; Schema: jafc; Owner: -
--

CREATE INDEX ix_jafc_page_alias ON jafc.jafc_page USING btree (alias);


--
