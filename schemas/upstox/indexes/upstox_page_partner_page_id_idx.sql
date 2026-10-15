-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_page_partner_page_id_idx
-- Type: INDEX

-- Name: upstox_page_partner_page_id_idx; Type: INDEX; Schema: upstox; Owner: -
--

CREATE INDEX upstox_page_partner_page_id_idx ON upstox.upstox_page_partner USING btree (page_id);


--
