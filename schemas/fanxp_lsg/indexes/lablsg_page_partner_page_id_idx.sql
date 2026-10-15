-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_lsg
-- Object: lablsg_page_partner_page_id_idx
-- Type: INDEX

-- Name: lablsg_page_partner_page_id_idx; Type: INDEX; Schema: fanxp_lsg; Owner: -
--

CREATE INDEX lablsg_page_partner_page_id_idx ON fanxp_lsg.lablsg_page_partner USING btree (page_id);


--
