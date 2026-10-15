-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: ix_gpn_client_notification_map_nid
-- Type: INDEX

-- Name: ix_gpn_client_notification_map_nid; Type: INDEX; Schema: gpn; Owner: -
--

CREATE INDEX ix_gpn_client_notification_map_nid ON gpn.gpn_client_notification_map USING btree (notification_id);


--
