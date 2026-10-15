-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_page_alias_idx
-- Type: INDEX

-- Name: upstox_page_alias_idx; Type: INDEX; Schema: upstox; Owner: -
--

CREATE INDEX upstox_page_alias_idx ON upstox.upstox_page USING btree (alias);


--
