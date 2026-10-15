-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: upstox_page_alias_idx
-- Type: INDEX

-- Name: upstox_page_alias_idx; Type: INDEX; Schema: labupstox; Owner: -
--

CREATE INDEX upstox_page_alias_idx ON labupstox.labupstox_page USING btree (alias);


--
