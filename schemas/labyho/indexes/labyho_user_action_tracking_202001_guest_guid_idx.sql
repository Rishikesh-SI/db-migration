-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_user_action_tracking_202001_guest_guid_idx
-- Type: INDEX

-- Name: labyho_user_action_tracking_202001_guest_guid_idx; Type: INDEX; Schema: labyho; Owner: -
--

CREATE INDEX labyho_user_action_tracking_202001_guest_guid_idx ON labyho.labyho_user_action_tracking_202001 USING btree (guest_guid);


--
